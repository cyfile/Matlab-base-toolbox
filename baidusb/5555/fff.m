% 直接打开demo和doc的命令
web url

web www.baidu.com -browser

web([docroot '/techdoc/ref/figure_props.html#WindowButtonMotionFcn'])

web([docroot '/techdoc/ref/matlabwindows.html']) %这一句只能这样写，doc matlabwindows 是不行的

edit([docroot '/techdoc/ref/examples/figure_button_down_fcn'])

run([docroot '/techdoc/ref/examples/figure_button_down_fcn'])

showdemo(bdroot(gcs))
showdemo('sldemo_hydcyl')

showdemo('filterguitardemo')

demo('simulink','General Applications')

playshow filterguitardemo

 

demo 'simulink' 'general'


help(cd)