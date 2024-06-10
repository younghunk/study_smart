package com.example.demo.board.hyeonsik.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.board.hyeonsik.dao.PostDao;

@Service
public class PostService {

    @Autowired
    private PostDao postDao;

    // ID로 게시글 찾기
    public HashMap<String, Object> getPostById(Long id) {
        return postDao.getPostById(id);
    }
    
    // 모든 게시글 리스트 가져오기
    public List<HashMap<String, Object>> getAllPosts(Map<String, Object> params) {
        return postDao.getAllPosts(params);
    }

    // 게시글 등록
    public void createPost(HashMap<String, Object> post) {
        postDao.insertPost(post);
    }

    // 게시글 업데이트
    public void updatePost(HashMap<String, Object> post) {
        postDao.updatePost(post);
    }

    // 게시글 삭제
    public void deletePost(HashMap<String, Object> post) {
        postDao.deletePost(post);
    }

    // 조회수 증가
    public void incrementViewCount(Long id) {
        postDao.viewUp(id);
    }

    // 게시글에 따른 댓글 조회
    public List<HashMap<String, Object>> getCommentsByPostId(Long postId) {
        return postDao.getCommentsByPostId(postId);
    }

    // 댓글 등록
    public void createComment(HashMap<String, Object> post) {
        postDao.insertComment(post);
    }

    // 댓글 삭제
    public void deleteComment(HashMap<String, Object> post) {
        postDao.deleteComment(post);
    }

    // 게시글 요청 등록
    public void createPostRequest(HashMap<String, Object> request) {
        postDao.insertPostReq(request);
    }

    // 게시글 요청 업데이트
    public void updatePostRequest(HashMap<String, Object> request) {
        postDao.updatePostReq(request);
    }

    // 답글 달기 위한 게시물 등록
    public void createReplyPost(HashMap<String, Object> post) {
        postDao.insert2Post(post);
    }
}