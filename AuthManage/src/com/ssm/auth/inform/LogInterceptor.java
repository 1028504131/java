package com.ssm.auth.inform;

import java.util.Arrays;
import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LogInterceptor {

	// 声明该方法是一个前置通知：在目标方法之前执行
	@Before("execution(* com.ssm.auth.controller.*.*(..))")
	public void beforeMethod(JoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		List<Object> args = Arrays.asList(joinPoint.getArgs());
		System.out.println("前置通知:执行" + methodName + "方法" + args);
	}

}
