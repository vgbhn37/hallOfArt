package com.silver.hallofart.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.silver.hallofart.dto.FileDto;
import com.silver.hallofart.dto.HallTimeDto;
import com.silver.hallofart.dto.Pagination;
import com.silver.hallofart.dto.PagingDto;
import com.silver.hallofart.dto.ShowDetailDto;
import com.silver.hallofart.repository.model.Hall;
import com.silver.hallofart.repository.model.Rental;
import com.silver.hallofart.repository.model.Seat;
import com.silver.hallofart.repository.model.Show;
import com.silver.hallofart.service.AdminService;
import com.silver.hallofart.service.ShowService;

@Controller
@RequestMapping("/show")
public class ShowController {

	@Autowired
	private ShowService showService;
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/main")
	public String main() {
		return "show/main";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam Integer id, Model model) {
		ShowDetailDto show = showService.showById(id);
		model.addAttribute("show", show);
		return "show/detail";
	}
	
	@GetMapping("/schedule")
	public String scheduleProc(@ModelAttribute("paging") PagingDto paging
										  ,@RequestParam(value="page", required = false, defaultValue="1") int page
										  ,@RequestParam(value="date", required = false ) String date
										  , Model model) {
		
		paging.setPage(page);
		Pagination pagination = new Pagination();
		pagination.setPaging(paging);
		pagination.setArticleTotalCount(adminService.countShow(pagination));
		
		Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yy-MM-dd");
        String now = dateFormat.format(currentDate);
        
        System.out.println("schedule date : "+date+", now : "+now);
		
        System.out.println("paging offset : "+paging.getOffset());
        System.out.println("paging recordSize : "+paging.getRecordSize());

        
		List<Show> list = null;
		
		if(date==null) {
			list = showService.showListByDate(now, paging.getOffset(), paging.getRecordSize());
		}else {
			list = showService.showListByDate(date, paging.getOffset(), paging.getRecordSize());
		}
		System.out.println("schedule list : "+list);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("list", list);
		
		return "show/schedule";
	}
	
	@GetMapping("/apply")
	public String apply(Model model) {
		
		List<Hall> halls = showService.findHallAll();
		model.addAttribute("halls", halls);
		
		return "show/applyShow";
	}
	
	@PostMapping("/hallTime")
	@ResponseBody
	public List<String> hallTime(String name){
		List<String> list = showService.findAllHallTime(name);
		return list;
	}
	
	@Transactional
	@PostMapping("/apply")
	public String applying(Show show, Rental rental, String startTime) {
		System.out.println("applying show : "+show);
		System.out.println("applying seat : "+rental);
		try {
			showService.insertShow(show);
			showService.insertShowTime(startTime);
			showService.insertRental(rental);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:apply";
	}
	
	
	@PostMapping("/upload")
	@ResponseBody
	public String upload(@RequestPart("uploadImg") 
			MultipartFile[] uploadfile, Model model) {

		List<FileDto> list = new ArrayList<>();

		for (MultipartFile file : uploadfile) {			
			FileDto dto = new FileDto( file.getOriginalFilename(), file.getContentType() );	
			list.add(dto);
			File newFileName = new File(dto.getFileName());
	        
			try {
				file.transferTo(newFileName);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list.get(0).getFileName();
	}
}
