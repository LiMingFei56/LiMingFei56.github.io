---
layout: post
title: "Security AES"
categories: sec
tags: [sec]
date: 2021-04-19
---

## Security AES

### Dart AES

		import 'package:encrypt/encrypt.dart';

		final aesKey = Key.fromUtf8('wWKK335SKLDFJ146');
		final iv = IV.fromLength(16);
		final encrypter = Encrypter(AES(aesKey, mode: AESMode.cbc, padding: 'PKCS7'));
		final encrypted = encrypter.encrypt(content, iv: iv);
		final decrypted = encrypter.decrypt(encrypted, iv: iv);

		print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
		print(encrypted.base64);


### Java AES
		
		import java.security.spec.AlgorithmParameterSpec;
		import java.util.Base64;
		import javax.crypto.Cipher;
		import javax.crypto.spec.IvParameterSpec;
		import javax.crypto.spec.SecretKeySpec;

		/**
		 * 加密
		 *
		 * @param content
		 * @param key
		 * @return
		 */
		public static String encrypt(@NotNull String content, @NotNull String key) {
			byte[] result = null;
			try {
				Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
				SecretKeySpec keySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
				AlgorithmParameterSpec paramSpec = new IvParameterSpec(new byte[16]);
				cipher.init(Cipher.ENCRYPT_MODE, keySpec, paramSpec);
				result = cipher.doFinal(content.getBytes("UTF-8"));
			} catch (Exception ex) {
			}
			return Base64.getEncoder().encodeToString(result);
		}

		/**
		 * 解密
		 *
		 * @param content
		 * @param key
		 * @return
		 */
		public static String decrypt(@NotNull String content, @NotNull String key) {
			try {
				Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
				SecretKeySpec keySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
				AlgorithmParameterSpec paramSpec = new IvParameterSpec(new byte[16]);
				cipher.init(Cipher.DECRYPT_MODE, keySpec, paramSpec);
				return new String(cipher.doFinal(Base64.getDecoder().decode(content)), "UTF-8");
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			return "";
		}



### Reference
[高级加密标准](https://zh.wikipedia.org/wiki/%E9%AB%98%E7%BA%A7%E5%8A%A0%E5%AF%86%E6%A0%87%E5%87%86)  
[Advanced Encryption Standard](https://searchsecurity.techtarget.com/definition/Advanced-Encryption-Standard)  
[Advanced Encryption Standard](https://www.tutorialspoint.com/cryptography/advanced_encryption_standard.htm)  
[initialization vector](https://zh.wikipedia.org/wiki/%E5%88%9D%E5%A7%8B%E5%90%91%E9%87%8F)  
