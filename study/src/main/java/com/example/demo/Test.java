package com.example.demo;

import java.security.PrivateKey;
import java.security.PublicKey;
import java.util.HashMap;

import com.example.demo.util.RsaUtil;

public class Test {

	public static void main(String[] args) {
		RsaUtil rsaUtil = new  RsaUtil();
		HashMap<String, Object> keys = rsaUtil.createRSA();
		PrivateKey privateKey = (PrivateKey) keys.get("privateKey");
		PublicKey publicKey = (PublicKey) keys.get("publicKey");
		
		String plainText = "김영훈";
		try {
			String encryptedText = rsaUtil.setEncryptText(publicKey, plainText);
			System.out.println(">>>>>>>>>>encryptedText:"+encryptedText);
			String decryptedText = rsaUtil.getDecryptText(privateKey, encryptedText);
			System.out.println(">>>decryptedText:"+decryptedText);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

}
