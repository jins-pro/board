package org.jins.service;

import org.jins.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {

	@Autowired
	private BoardService service;
	
	@Test
	public void testPrint() {
		
		log.info(service);
		
	}
	
	@Test
	public void testGetList() {
		
		service.getList().forEach(board -> log.info(board));
		
	}
	
	@Test
	public void testRegister() {
		
		BoardVO vo = new BoardVO();
		vo.setTitle("AAATest r테스트");
		vo.setContent("AAAContent r테스트");
		vo.setWriter("tester");
		
		//long bno = service.register(vo);
		
		//log.info("BNO : "+bno);
	}
}
