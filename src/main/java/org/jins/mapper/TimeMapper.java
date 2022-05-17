package org.jins.mapper;

import org.apache.ibatis.annotations.Select;

//org.jins.mapper.TimeMapper.getTime2 ->

public interface TimeMapper {

	@Select("select sysdate from dual") // 세미콜론 생략 
	String getTime(); // public 생략
	
	String getTime2();
}
