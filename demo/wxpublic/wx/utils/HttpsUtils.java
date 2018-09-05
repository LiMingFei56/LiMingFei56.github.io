package org.ppnsr.wx.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

public class HttpsUtils {

	public static String httpGet(URL url) {
		String response = null;
		InputStream input = null;
		ByteArrayOutputStream bufOutPut = null;
		try {
			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
			conn.setConnectTimeout(5000);// 5
			conn.setReadTimeout(5000);
			conn.setRequestMethod("GET");
			conn.setRequestProperty("User-Agent", "");
			conn.setRequestProperty("Charset", "UTF-8");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			input = conn.getInputStream();
			byte[] buf = new byte[8 * 1024];
			int len = 0;

			bufOutPut = new ByteArrayOutputStream();
			while ((len = input.read(buf)) != -1) {
				bufOutPut.write(buf, 0, len);
			}
			bufOutPut.flush();

			response = new String(bufOutPut.toByteArray(), "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
			WeiXinLog.error("请求失败 --" + e.toString() + " url=" + url.toString());
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (bufOutPut != null) {
				try {
					bufOutPut.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return response;
	}
	
	public static String httpPost(URL url, String body) {
		String response = null;
		OutputStream output = null;
		InputStream input = null;
		ByteArrayOutputStream bufOutPut = null;
		try {
			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
			conn.setConnectTimeout(5000);// 5
			conn.setReadTimeout(5000);
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("User-Agent", "");
			conn.setRequestProperty("Charset", "UTF-8");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			output = conn.getOutputStream();
			output.write(body.getBytes("UTF-8"));
			
			input = conn.getInputStream();
			byte[] buf = new byte[8 * 1024];
			int len = 0;

			bufOutPut = new ByteArrayOutputStream();
			while ((len = input.read(buf)) != -1) {
				bufOutPut.write(buf, 0, len);
			}
			bufOutPut.flush();

			response = new String(bufOutPut.toByteArray(), "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
			WeiXinLog.error("请求失败 --" + e.toString() + " url=" + url.toString());
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (bufOutPut != null) {
				try {
					bufOutPut.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return response;
	}
}
