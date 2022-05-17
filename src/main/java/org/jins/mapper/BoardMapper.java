package org.jins.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.jins.domain.BoardVO;
import org.jins.domain.Criteria; 

public interface BoardMapper {

	
	List<BoardVO> getList();
	
	void insert(BoardVO board);
	
	void insertSelectKey(BoardVO board);
	
	BoardVO read(Long bno);
	
	int delete(Long bno);
	
	int update(BoardVO board);
	
	List<BoardVO> getListWithPaging(Criteria cri);
	
	int getTotalCount(Criteria cri);  //검색 조건에 이용하기 위해 Criteria를 받음
	
	List<BoardVO> searchTest(Map<String, Map<String,String>> map);
	
	void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
