package com.example.demo.board.hyeonsik.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.demo.board.hyeonsik.service.PostService;



@Controller
public class PostController {

    @Autowired
    private PostService postService;
    
    
    @GetMapping("/") 
    	String listpage() {
    		return "/board/hyeonsik/hyeonsik_list.tiles-study";				
    }
    
    @GetMapping("/hyeonsik_edit") 
	String editpage() {
		return "/board/hyeonsik/hyeonsik_edit";				
	} 
    
    @GetMapping("/hyeonsik_post") 
    public String postpage(@RequestParam("id") Long id, Model model) {
        HashMap<String, Object> post = postService.getPostById(id); // 게시물 가져오기
        postService.incrementViewCount(id); // 조회수 증가
        model.addAttribute("post", post); // 모델에 게시물 추가
        return "/board/hyeonsik/hyeonsik_post"; // 뷰 반환
    }
    
    @GetMapping("/hyeonsik_post2") 
	String post2page(@RequestParam("id") Long id, Model model) {
     	HashMap<String, Object> post = postService.getPostById(id); // 게시물 가져오기
    	model.addAttribute("post", post); // 모델에 게시물 추가
		return "/board/hyeonsik/hyeonsik_post2";				
	}
    
    @GetMapping("/hyeonsik_write") 
	String writepage() {
		return "/board/hyeonsik/hyeonsik_write";				
	}
    
    @GetMapping("/hyeonsik_add") 
  	String addpage(@RequestParam("id") Long id, Model model) {
    	HashMap<String, Object> post = postService.getPostById(id); // 게시물 가져오기
    	model.addAttribute("post", post); // 모델에 게시물 추가
  		return "/board/hyeonsik/hyeonsik_add";				
  	}
    
    
   
    // 게시글 리스트 조회
    @RequestMapping(value = "/posts", method = RequestMethod.GET)
    @ResponseBody
    public List<HashMap<String, Object>> getAllPosts(@RequestParam Map<String, Object> params) {
        return postService.getAllPosts(params);
    }

    // 게시글 등록
    @RequestMapping(value = "/posts/insert", method = RequestMethod.POST)
    @ResponseBody
    public void createPost(@RequestBody HashMap<String, Object> post) {
    	//게시글 등록
        postService.createPost(post);
        //답글을 달기 위한 게시물 등록간 orginNo 번호를 id 값으로 넣는다
        postService.createReplyPost(post);
    }
    
    //답글 등록
    @RequestMapping(value = "/posts/insertreq", method = RequestMethod.POST)
    @ResponseBody
    public void createPostreq(@RequestBody HashMap<String, Object> post) {
    	//한 글에 대한 답글이 여러개인 경우 우선순위를 맞춰주기 위함
    	postService.updatePostRequest(post);
    	//답글 등록
        postService.createPostRequest(post);
    }

    // 게시글 업데이트
    @RequestMapping(value = "/posts/update", method = RequestMethod.POST)
    @ResponseBody
    public void updatePost(@RequestBody HashMap<String, Object> post) {
        postService.updatePost(post);
    }

    // 게시글 삭제
    @RequestMapping(value = "/posts/delete", method = RequestMethod.POST)
    @ResponseBody
    public void deletePost(@RequestBody HashMap<String, Object> post) {
        postService.deletePost(post);
    }


    // 댓글 리스트 조회
    @RequestMapping(value = "/posts/{postId}/comments", method = RequestMethod.GET)
    @ResponseBody
    public List<HashMap<String, Object>> getCommentsByPostId(@PathVariable Long postId) {
    	
        return postService.getCommentsByPostId(postId);
    }

    // 댓글 등록
    @RequestMapping(value = "/{postId}/comments", method = RequestMethod.POST)
    @ResponseBody
    public void createComment(@RequestBody HashMap<String, Object> post) {
        postService.createComment(post);
    }

//     댓글 삭제(아직안됨)
//    @RequestMapping(value = "/posts/comments/{commentId}", method = RequestMethod.POST)
//    @ResponseBody
//    public void deleteComment(@PathVariable Long commentId) {
//        postService.deleteComment(commentId);
//    }
}