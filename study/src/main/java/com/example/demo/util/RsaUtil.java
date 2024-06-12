package com.example.demo.util;

import java.security.*;
import javax.crypto.Cipher;
import java.util.HashMap;

public class RsaUtil {
    private KeyPairGenerator generator;
    private KeyFactory keyFactory;
    private KeyPair keypair;
    private Cipher cipher;

    public RsaUtil() {
        try {
            generator = KeyPairGenerator.getInstance("RSA");
            generator.initialize(1024);
            keyFactory = KeyFactory.getInstance("RSA");
            cipher = Cipher.getInstance("RSA");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public HashMap<String, Object> createRSA() {
        HashMap<String, Object> rsa = new HashMap<>();
        try {
            keypair = generator.generateKeyPair();
            PublicKey publicKey = keypair.getPublic();
            PrivateKey privateKey = keypair.getPrivate();

            rsa.put("privateKey", privateKey);
            rsa.put("publicKey", publicKey);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rsa;
    }

    public String getDecryptText(PrivateKey privateKey, String encryptedText) throws Exception {
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(hexToByteArray(encryptedText));
        return new String(decryptedBytes, "UTF-8");
    }

    public String setEncryptText(PublicKey publicKey, String plainText) throws Exception {
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());
        return byteArrayToHex(encryptedBytes);
    }

    private byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[]{};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }

    private String byteArrayToHex(byte[] byteArray) {
        if (byteArray == null || byteArray.length == 0) {
            return "";
        }

        StringBuilder sb = new StringBuilder(byteArray.length * 2);
        for (byte b : byteArray) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();
    }
}

