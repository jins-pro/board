package org.jins.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.jins.domain.BoardAttachVO;
import org.jins.domain.BoardVO;
import org.jins.domain.Criteria;
import org.jins.domain.PageDTO;
import org.jins.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sun.jmx.mbeanserver.ModifiableClassLoaderRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor // allargs대신 사용
@RequestMapping("/board/*")
@Log4j
public class BoardController {

	
	private final BoardService service;  // final = 옆 계층만 봐야하기때문에 
	
	/*@GetMapping("/list")
	public void list(Model model) {
		
		log.info("list.................");
		
		model.addAttribute("list", service.getList());
	}*/
	
	//전체 게시글
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("========List========");
		log.info(cri);
		log.info("====================");
		// 게시판 목록
		model.addAttribute("list", service.getList(cri)); //10줄 리스트 내용 List에 담음
		// 게시판 페이지
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));
	}
	
	@PostMapping("/modlist")
	public String modlist(Criteria cri, RedirectAttributes rttr) {
		
		log.info("==========??==============");
		log.info(cri);
		log.info("list.................");
		
		/*model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));*/
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}
	@GetMapping("/register")
	public void registerGET() {
		
	}
	
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("===========register=============");
		log.info("register : " +board);
		if(board.getAttachList() != null) { //첨부파일 O, 첨부파일 확인 로그
			log.info("ddd");
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("========================");
		//Long bno = service.register(board);
		//log.info("BNO : "+bno);
		//rttr.addFlashAttribute("result", bno); //등록 도배 방지위해 FLASH 사용
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		/*rttr.addAttribute(attributeValue)는 리턴 경로 뒤에 남김*/
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno")Long bno,
					@ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		log.info("modify확인:" + board);
		if (service.modify(board)) { //true
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, 
						Criteria cri, RedirectAttributes rttr) {
		log.info("remove..." + bno);
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if (service.remove(bno)) {
			// delete Attach Files
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListLink();
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
	    if(attachList == null || attachList.size() == 0) {
	      return;
	    }
	    log.info("delete attach files...................");
	    log.info(attachList);
	    attachList.forEach(attach -> {
	      try {        
	        Path file  = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" 
	        			+ attach.getUuid()+"_"+ attach.getFileName());
	        Files.deleteIfExists(file);
	        if(Files.probeContentType(file).startsWith("image")) {
	          Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" 
	        		  		+ attach.getUuid()+"_"+ attach.getFileName());
	          Files.delete(thumbNail);
	        }
	      }catch(Exception e) {
	        log.error("delete file error" + e.getMessage());
	      }//end catch
	    });//end foreachd
	  }
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList : "+ bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	
	
}
