package com.example.demo.board.hyeonsik.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.board.hyeonsik.dao.PostDao;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Service
public class PdfService {

    @Autowired
    private PostDao postDao;

    public void createPdf(HttpServletResponse response) throws IOException {
        try {
            Document document = new Document(); // pdf문서를 처리하는 객체
            PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
            document.open(); // 웹페이지에 접근하는 객체 open

            Font font = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL);
            Font headerFont = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD, BaseColor.WHITE);

            PdfPTable table = new PdfPTable(4); // 4개의 셀을 가진 테이블 객체를 생성
            table.setWidthPercentage(100);

            PdfPCell cell1 = new PdfPCell(new Paragraph("번호", headerFont)); // 셀의 이름과 폰트를 지정해서 셀을 생성
            cell1.setHorizontalAlignment(Element.ALIGN_CENTER); // 셀의 정렬방식(가운데정렬)
            cell1.setBackgroundColor(BaseColor.GRAY);

            PdfPCell cell2 = new PdfPCell(new Paragraph("제목", headerFont));
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);

            PdfPCell cell3 = new PdfPCell(new Paragraph("작성자", headerFont));
            cell3.setHorizontalAlignment(Element.ALIGN_CENTER);

            PdfPCell cell4 = new PdfPCell(new Paragraph("작성일", headerFont));
            cell4.setHorizontalAlignment(Element.ALIGN_CENTER);

            table.addCell(cell1); // 그리고 테이블에 위에서 생성시킨 셀을 넣는다.
            table.addCell(cell2);
            table.addCell(cell3);
            table.addCell(cell4);

            List<HashMap<String, Object>> posts = postDao.getAllPosts(null);

            for (HashMap<String, Object> post : posts) {
                PdfPCell cellId = new PdfPCell(new Paragraph(String.valueOf(post.get("id")), font)); // 반복문을 사용해서 상품정보를 하나씩 출력해서 셀에 넣고 테이블에 저장한다
                PdfPCell cellTitle = new PdfPCell(new Paragraph(String.valueOf(post.get("title")), font));
                PdfPCell cellWriter = new PdfPCell(new Paragraph(String.valueOf(post.get("writer")), font));
                PdfPCell cellCreatedDate = new PdfPCell(new Paragraph(String.valueOf(post.get("createdDate")), font));

                table.addCell(cellId);
                table.addCell(cellTitle);
                table.addCell(cellWriter);
                table.addCell(cellCreatedDate);
            }

            response.setHeader("Content-Disposition", "attachment; filename=posts.pdf"); // 다운로드 헤더 설정
            response.setContentType("application/pdf"); // MIME 타입 설정

            document.add(table); // 웹접근 객체에 table를 저장한다.
            document.close(); // 저장이 끝났으면 document객체를 닫는다.

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}