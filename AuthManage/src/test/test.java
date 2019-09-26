package test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ssm.auth.dao.RoleMapper;
import com.ssm.auth.dao.UserInfoMapper;
import com.ssm.auth.vo.UserInfo;



public class test {
	public static void main(String[] args) {
		
		ApplicationContext ac = new ClassPathXmlApplicationContext("spring.xml");
		RoleMapper us =(RoleMapper)ac.getBean("roleMapper");
		Map<String, Object> map = new HashMap<String, Object>();
		/*map.put("limitIndex", 0);
		map.put("pageSize",5);*/
		List<Integer> ais = us.seleRoleIdByuserId(1);
		for (Integer authInfo : ais) {
			System.out.println(authInfo);
		}
	}
}
