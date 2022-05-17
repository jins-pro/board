package org.jins.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.jins.domain.AttachFileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file){
		try {
			String contentType = Files.probeContentType(file.toPath());
			if(contentType == null) {return false;}
			return contentType.startsWith("image");
		}catch(IOException e) {e.printStackTrace();}
		return false;
	}
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	
	
	@PostMapping(value ="/uploadAjaxAction", 
				produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";
		String uploadFolderPath = getFolder();
		//make folder
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		// 연/월/일 폴더 생성 
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		for (MultipartFile multipartFile:uploadFile) { //for(타입 변수:배열)
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			String uploadFileName = multipartFile.getOriginalFilename();
			//IE has file path
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			log.info("only file name1: "+ uploadFileName);
			attachDTO.setFileName(uploadFileName);
			UUID uuid = UUID.randomUUID(); //uuid 랜덤 생성
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			log.info("only file name2: "+ uploadFileName);
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile); //transferTo() 파일 저장, 컴퓨터에 있는 파일을 프로그램으로 가져와 변환
				
				attachDTO.setUuid(uuid.toString()); // 유일ID
				attachDTO.setUploadPath(uploadFolderPath); //만들어진 폴더 위치
				//check image type file
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				}
				list.add(attachDTO);
			}catch(Exception e) {
				log.error(e.getMessage());
			} // end catch
		}//end for
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName : "+ fileName);
		
		File file = new File("c:\\upload\\"+fileName);
		log.info("file : "+file);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header, HttpStatus.OK);
		}catch(IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping(value = "/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, 
												String fileName){
		log.info("download file: " + fileName);
		Resource resource = new FileSystemResource("c:\\upload\\"+fileName);
		log.info("resource: "+resource);
		if(resource.exists() == false) { //없으면 false
			return new ResponseEntity<>(HttpStatus.NOT_FOUND); // 상태코드 404 내보냄
		}
		String resourceName = resource.getFilename();
		//remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		HttpHeaders headers = new HttpHeaders();
		try {
			String downloadName = null;
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("//+"," ");
			}else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				log.info("Edge name:" + downloadName);
			}else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"),"iso-8859-1");
			}
			log.info("downloadName: " + downloadName);
			headers.add("Content-Disposition", "attachment; filename " + downloadName); 
			log.info("확인"+headers);
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("deleteFile: "+fileName);
		File file;
		try {
			file = new File("c:\\upload\\"+ URLDecoder.decode(fileName, "UTF-8"));
			System.out.println("파일1: "+file);
			file.delete();
			if(type.equals("image")) {
				log.info("확인");
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName: "+largeFileName);
				file = new File(largeFileName);
				System.out.println("파일2: "+file);
				file.delete();
			}
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}
}
