<!-- header page에서 tiles 설정 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        /* 메뉴 스타일 */
        nav {
            padding: 20px;
            font-size: 18px; 
            background-color: #f2f2f2; 
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
            width: 200px; 
        }

        nav div {
            margin-bottom: 10px;
        }

        nav a {
            display: block; 
            padding: 10px 20px; 
            color: #333; 
            text-decoration: none; 
            transition: background-color 0.3s; 
        }

        nav a:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <div style="float: left; padding: 10px;">
        <nav>
            <div><a href="/">최현식 주임</a></div>
            <div><a href="/jinyoung/list.action">김진영 주임</a></div>
        </nav>
    </div>
</body>
</html>