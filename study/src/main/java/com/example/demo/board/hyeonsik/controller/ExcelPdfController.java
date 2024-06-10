package com.example.demo.board.hyeonsik.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.board.hyeonsik.service.ExcelService;
import com.example.demo.board.hyeonsik.service.PdfService;
import com.example.demo.board.hyeonsik.service.PostService;


@Controller
public class ExcelPdfController {
	
	@Autowired
	public PostService postService;
	
	@Autowired
	public ExcelService excelService;
	
	@Autowired
	public PdfService pdfService;
	
	
	//엑셀 다운로드
	@GetMapping("/download/excel")
	public void downloadPostsAsExcel(HttpServletResponse response) throws IOException {
		excelService.generateExcel(response);
		
	}	
	
	//pdf 다운로드
	 @GetMapping("/download/pdf")
	 public void downloadPdf(HttpServletResponse response) throws IOException {
		    pdfService.createPdf(response); // PDF 생성
		   
		  
		}
}

