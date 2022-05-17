package org.jins.persistence;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

	@Test
	public void testConnection()throws Exception {
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		
			Connection con = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:XE",
					"board_ex","board_ex");
			
			log.info(con);
			con.close(); //bad code
		
		
		
	}
	
	
}
