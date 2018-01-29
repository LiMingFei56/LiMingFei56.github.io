package com.ems.teamsun.nocar.three;

import android.util.Log;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketAddress;
import java.util.HashMap;

/**
 * Created by lmf on 17-11-9.
 */

public class ListenerLocation {

    private static ListenerLocation mInstance;

    static {
        mInstance = new ListenerLocation();
    }

    public static ListenerLocation getInstance() {
        return mInstance;
    }

    private ListenerLocation() {
    }

    private ServerSocket serverSocket;
    private boolean isRun = false;

    public void start() {
        try {
            serverSocket = new ServerSocket(6677, 50, InetAddress.getByName("127.0.0.1"));
            isRun = true;
            new Thread(new HttpListenerRun()).start();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void stop() {
        isRun = false;
        try {
            serverSocket.close();
            serverSocket = null;
        } catch (IOException e) {
        }
    }

    public boolean isRunning() {
        return isRun && serverSocket != null;
    }

    private String handlerRequest(HashMap<String, String> paramiterMap) {
        String type = paramiterMap.get("type");

        String content = null;
        switch (type) {
            // 验证是否存在
            case "1":
                content = "{\"exist\":\"1\"}";
                break;
            // 跳转到货源广场
            case "2":
                content = "{\"success\":\"1\"}";
                break;
            default:
                content = "{\"success\":\"0\"}";
                break;
        }
        return content;
    }

    private class HttpListenerRun implements Runnable {

        @Override
        public void run() {
            Socket socket = null;
            while (isRun) {
                try {
                    socket = serverSocket.accept();

                    BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));

                    String line = null;
                    boolean isFinish = false;

                    HashMap<String, String> parameterMap = new HashMap<>();
                    while (true) {
                        line = reader.readLine();
                        if ("".equals(line)) {
                            break;
                        }

                        if (line.startsWith("GET")) {
                            int startIndex = line.indexOf("?") + 1;
                            int endIndex = line.indexOf(" ", startIndex);
                            String requestParam = line.substring(startIndex, endIndex);
                            String[] requestParamArr = requestParam.split("&");
                            for (String requestParamItem :
                                    requestParamArr) {
                                String[] content = requestParamItem.split("=");
                                parameterMap.put(content[0], content[1]);
                            }
                        } else if (line.indexOf(": ") != -1) {
                            String[] content = line.split(": ");
                            parameterMap.put(content[0], content[1]);
                        }
                    }

                    String responseContent = handlerRequest(parameterMap);

                    writer.write("HTTP/1.1 200\r\n" +
                            "Content-Type: text/html;charset=UTF-8\r\n" +
                            "Content-Length: " + responseContent.length() + "\r\n" +
                            "Date: Thu, 09 Nov 2017 08:57:01 GMT\r\n\r\n" +
                            responseContent);
                    writer.flush();
                    writer.close();
                    socket.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
