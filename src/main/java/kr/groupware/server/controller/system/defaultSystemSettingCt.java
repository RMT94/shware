package kr.groupware.server.controller.system;

import kr.groupware.model.system.defaultSystem.DefaultSystemSettingData;
import kr.groupware.model.system.defaultSystem.DefaultSystemSettingSv;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping(value = "/system")
public class defaultSystemSettingCt {
    @Autowired
    DefaultSystemSettingSv defaultSystemSettingSv;

    @RequestMapping(value = "/defaultSystemSetting.do",method = RequestMethod.GET)
    public ModelAndView getDefaultSystemSettings(){
        ModelAndView mv=new ModelAndView("/system/defaultSystemSetting");
        List<DefaultSystemSettingData> defaultSystemSettingData=defaultSystemSettingSv.getDefaultSystemSettings();
        mv.addObject("defaultSystemSettings",defaultSystemSettingData);
        return mv;
    }

    @RequestMapping(value = "/modifyBrowserTitle.do",method = RequestMethod.POST)
    public String modifyBrowserTitle(
            DefaultSystemSettingData defaultSystemSettingData
    ){
        defaultSystemSettingSv.modifyBrowserTitle(defaultSystemSettingData);
        return "redirect:/system/defaultSystemSetting.do";
    }

}
