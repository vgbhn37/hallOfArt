package com.silver.hallofart.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.silver.hallofart.repository.model.Show;
import com.silver.hallofart.service.ShowService;

@Controller
@RequestMapping("/show")
public class ShowController {

	@Autowired
	private ShowService showService;
	
	@GetMapping("/main")
	public String main() {
		return "show/main";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam Integer id, Model model) {
		Show show = showService.showById(id);
		model.addAttribute("show", show);
		return "show/detail";
	}
	
	@GetMapping("/schedule")
	public String schedule() {
		return "show/schedule";
	}
	
	@GetMapping("/apply")
	public String apply() {
		return "show/applyShow";
	}
	@PostMapping("/apply")
	public String applying(Show show) {
		System.out.println("applying show : "+show);
		showService.insertShow(show);
		return "redirect:applyShow";
	}
	
	@PostMapping("/schedule_proc")
	@ResponseBody
	public List<Show> scheduleProc(String startDate, String endDate) {
//		System.out.println("scheduleProc 실행됨");
		List<Show> list = showService.showListByDate(startDate, endDate);
		System.out.println(list);

		return list;
	}
}