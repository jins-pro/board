package org.jins.domain;

import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
public class PageDTO {
	private int startPage, endPage;
	private boolean prev, next;
	private int total;
	private Criteria cri;
	public PageDTO(Criteria cri, int total) {
		this.cri = cri; 		// cri=Criteria(pageNum=95024, amount=10, keyword=, type=)
		this.total = total;		// total=950276
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10; // endPage=95028
		this.startPage = endPage - 9; 							   // startPage=95021
		this.prev = this.startPage > 1;							   // true
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()) );// realEnd=95028
		this.endPage = realEnd <= endPage? realEnd : endPage;	   // 95028 <= 95028, true, endPage=95028
		this.next = this.endPage < realEnd; //95028 < 95028 , false
	}
}
