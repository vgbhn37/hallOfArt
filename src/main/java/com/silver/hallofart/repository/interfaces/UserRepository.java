package com.silver.hallofart.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.silver.hallofart.dto.Criteria;
import com.silver.hallofart.dto.UserDto;

@Mapper
public interface UserRepository {
	public int insert(UserDto dto);
	public int updateById(UserDto user);
	public int updatePassByUsername(@Param("username") String username, @Param("password") String password);
	public int deleteById(Integer id);
	public int userTotalCount();
	public UserDto findById(Integer id);
	public List<UserDto> findAll();
	public List<UserDto> findAllUserPaging(Criteria cri);
	public UserDto findByUsernameAndPassword(UserDto signInFormDto);
	public UserDto findByUsername(String username);
	public UserDto findByEmail(String email);
	public UserDto findByTel(String tel);
}
