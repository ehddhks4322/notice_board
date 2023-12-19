package mvc;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kdw.bd.BoardController;
import com.kdw.bd.MemberController;

import dao.BoardDAO;
import dao.CommentsDAO;
import dao.MemberDAO;


@Configuration
@EnableWebMvc
//@ComponentScan("com.korea.json")
//컨트롤러 뿐만 아니라 Component의 자식요소를 전부 탐색해서 객체로 만들어준다.
/*
 *@Component
 *	ㄴ@Controller
 *	ㄴ@Service
 *	ㄴ@Repository 
 * */
//컴포넌트의 자식객체가 들어있으면 사실 Controller가 아니어도 만들어 질 수 있다.
public class Servlet_Context implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

	
//	  @Bean 
//	  public InternalResourceViewResolver resolver() {
//	  InternalResourceViewResolver resolver = new InternalResourceViewResolver();
//	  resolver.setViewClass(JstlView.class); resolver.setPrefix("/WEB-INF/views/");
//	  resolver.setSuffix(".jsp"); return resolver; }
	
	@Bean
	public BoardController boardController(BoardDAO board_dao,MemberDAO member_dao,CommentsDAO comments_dao) {
		return new BoardController(board_dao,member_dao,comments_dao);
	}
	
	@Bean
	public MemberController memberController(MemberDAO member_dao) {
		return new MemberController(member_dao);
	}
	
}
