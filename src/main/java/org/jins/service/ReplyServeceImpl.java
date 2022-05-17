package org.jins.service;

import java.util.List;

import org.jins.domain.Criteria;
import org.jins.domain.ReplyPageDTO;
import org.jins.domain.ReplyVO;
import org.jins.mapper.BoardMapper;
import org.jins.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@AllArgsConstructor
public class ReplyServeceImpl implements ReplyService{

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	/*@Autowired
	private ReplyMapper mapper;
	
	@Autowired
	private BoardMapper boardMapper;*/
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {

		log.info("register : " + vo);
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {

		log.info("get : " + rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify : " + vo);
		return mapper.update(vo);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {

		log.info("get Reply List of a Board : " + bno);
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Transactional
	@Override
	public int remove(Long rno) {

		log.info("remove : " + rno);
		ReplyVO vo = mapper.read(rno);
		
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {

		
		return new ReplyPageDTO(mapper.getCountByBno(bno),
				mapper.getListWithPaging(cri, bno));
	}

}
