package org.jins.service;

import java.util.List;

import org.jins.domain.BoardAttachVO;
import org.jins.domain.BoardVO;
import org.jins.domain.Criteria;
import org.jins.mapper.BoardAttachMapper;
import org.jins.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
@ToString
public class BoardServiceImpl implements BoardService {

	//private final BoardMapper mapper; //@requiredArgsConstructor 과 final 같이 사용
	
	@Setter(onMethod_= @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_= @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register........" + board);
		mapper.insertSelectKey(board);
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return; // 첨부파일 없으면 여기서 Break!!
		}
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno()); //uuid, path, name, type값 존재, bno 지정
			attachMapper.insert(attach);
		});
	}
	
	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove........"+bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}
	
	@Override
	public BoardVO get(Long bno) {
		return mapper.read(bno);
	}
	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		System.out.println("ghkrdls");
		log.info("modify 접근 확인");
		log.info("modify ::"+board);
		log.debug("modify ::"+board);
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = mapper.update(board) == 1;
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0){
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		System.out.println("확인"+modifyResult);
		return modifyResult;
	}

	@Override
	public List<BoardVO> getList() {

		return mapper.getList();
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno : " + bno);
		return attachMapper.findByBno(bno);
	}
}
