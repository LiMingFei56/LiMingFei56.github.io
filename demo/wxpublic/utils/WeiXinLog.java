package org.ppnsr.wx.utils;

import org.ppnsr.controller.base.BaseController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class WeiXinLog {
	private static final Logger logger = LoggerFactory.getLogger(BaseController.class);
	
	public static void debug(String msg) {
		logger.debug(msg);
	}
	
	public static void info(String msg) {
		logger.info(msg);
	}
	
	public static void error(String msg) {
		logger.error(msg);
	}
}
