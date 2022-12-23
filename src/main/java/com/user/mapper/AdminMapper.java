package com.user.mapper;

import java.util.List;
import java.util.Map;

//import com.user.model.PagingVO;
import com.user.model.UserVO;
public interface AdminMapper {

	int deleteUser(Integer midx);
	
	//List<UserVO> listUser(PagingVO pvo);
	
	List<UserVO> selectBoardAll(Map<String, Integer> map);
	
	int updateUser(UserVO user);

	UserVO selectUserByIdx(int idx);
	
	int getTotalCount();//총 게시글 수 가져오기 
	
	//List<UserVO> selectUserAll(PagingVO paging);
}
