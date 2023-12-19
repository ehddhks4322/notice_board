package context;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class Context_5_email {

	@Bean
	public JavaMailSender mailSender() {
		JavaMailSenderImpl mailSenderImpl = new JavaMailSenderImpl();
		
		//smtp설정
		mailSenderImpl.setHost("smtp.gmail.com");
		mailSenderImpl.setPort(587);
		mailSenderImpl.setUsername("ehddhks4322@gmail.com");
		mailSenderImpl.setPassword("uivabzyoynfwmlvh");
		
		//보안연결관련 설정
		Properties properties = new Properties();
		properties.put("mail.transport.protocol", "smtp");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtps.checkserveridentity", "true");
		properties.put("mail.smtps.ssl.Trust", "*");
		properties.put("mail.debug", "true");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		mailSenderImpl.setJavaMailProperties(properties);
		
		return mailSenderImpl;
	}
}
