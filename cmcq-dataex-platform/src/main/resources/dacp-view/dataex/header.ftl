<div class="wpcom-header">
	<!-- <div class="container"> -->
		<#assign getProperty= "com.asiainfo.dacp.dataex.platform.application.utils.ResMethod"?new()>
		<div class="wpcom-title" style="margin-top: 0; float: left;">
			<a href="#">${getProperty("com.asiainfo.dacp.web.controllers.LoginController.platformName")}</a>
		</div>
		<ul class="topNav">
			<li class="sys"><a href="${mvcPath}/dataex" class="topNav_con ${menuName!'active'}">平台介绍</a></li>
			<li class="">
				<a class="<#if menuName?? && menuName='apiCatalog'>active</#if> topNav_con" href="${mvcPath}/dataex/api_catalog">API目录</a>
			</li>
			<li class="">
				<a class="<#if menuName?? && menuName='document'>active</#if> topNav_con" href="${mvcPath}/ftl/dataex/documents/document">文档中心</a>
			</li>
			<li class="">
				<a class="<#if menuName?? && menuName='operation'>active</#if> topNav_con" href="${mvcPath}/dataex/operation">我的工作台</a>
			</li>
		</ul>
		<ul class="masterbar-tray">
			<li class="login">
			<#if userInfo??>
				<a class="click-wpcom-login" href="${mvcPath}/login"> <span class="login-word">欢迎， ${userInfo.name} </span>
					<span class="profile">
						<img style="width: 20px; height: 20px;"
						src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QAAAAAAAD5Q7t/AAAACXBIWXMAAAsSAAALEgHS3X78AAAEgElEQVRYw72ZW2hcRRjHf3P2ks2lJE02iW1CW0ESvBEhqWBjiqk+KFoVxVtpEVTQgvggPhURaQWlT4JtE0ULYkVRhLYpFmprHySt1kSNxEsTtCbGxNjNpeay2dv5fDhnc9lsNjMnqf+3w/m+b35z5puZb+YoPEhELGAz0Aw0ADVAFVDomkwBfwE9QAdwFvhWKWV7ac8ErFpEXheRfjFXv+tbfTXAykTkoIjEPIBlKubGKlstuEdF5PIqgGXqsog8thIwv4i0XAWwTLWIiN8UrkBE2v4HuLTaRKQgG4vK9uWAz4D7dTozEBW6x22+GE7ROWbzyxWbjYWKE1tDVOQpnRBpHQceVkollwNsBZ7Vibjv5wR7u+NIlnfXFVk0hi1Kg4o9NwRYG9SCfVsp9dySgG7SfqwT6Z+YsOH4NElZ3vbF2gD764K6X3KHUuqj9IM1D64MOKAb5VzE1oID+HHcaH0+ICLliwCB14CwbpTRuCYdMJUy4aMU2LcAUEQ2AE+bRMn36dtOJPQ74+opl2n2C+4GAiYRQpa+rd/A1lXAZcISZ+PfaRohajBshT6j5SatnSJipasSow28c9TmyW9i2vbtkRR7f4qbAlYDmy1gm6nn0IxgmlVdZjM5rWYLqDf1KjbKVkfXhDwNc4MF1Jp63VRsUZ2v32BJQLFrk4deQa0SkQhgXJtNJaHhVJTeydxDp4Dzd+XTUGo+lYERC1jjxbPQD4caggSXaXfXJr9XOIA1nj0Bmit8fLolRHEg+3A/UOXjUH3eSprAAiZWEuDe9T62lmfv5+Fb8wgZ7DhZNGEBQysKART5s39B3WIih4Ys4OJKIiQFvh5JURpUWMqZFDVu5nSNrfiUedECOr16R2LCjvMxLk0Jd1T4+HN7AZe2F/BQtTOuuzvjpqVWpjr8OIdqLV1JCO0Rm+/HbC6Mpjj9d4qY235diUWluxjfHvYBCX6btKk/FaWx3EdT2OKWtRaNYZ/Jon1WucVCHzn2465xm1e745wcSi2ZV21NIe5Z55vtSMXRaVJZbBVwW9jHnusD3L0u5wwaADZa7nXEkaWs3v8jyZbTUdoGUzmTvq5kbiYXBxQ3l2Sf2QKci6S476sZXvohnmtPP6KUstNRDgKLyo32SIpnLsRmh3EpVYYU6zO2vqbw8uvLmz0J3upNZHsVd5mcglUpNQC8m2n1YV9Sq2q5tnBxTt1YrLcHHB3IWlgedpkWnEleAUbmW32nuUx0jNoMzyzsSttgUsu3d2JRGyPAy+mHWUCl1Ajw/HzLvim9lTYp8EHfHFD/tHBySK/k/ndxYr/gsjhcmW/nH9zPDJsdx/b/6uTTg1W+2cVaR3dWzubrO0qp3JcGIhIUkWNeLliazkQl75NJGYzaXtyPiYje6d69PPrctIX3fk/II+0zXuBOLHV5lAsyICKtXlozVKuIeCq306CPy9W7wHzCM1gGZFici8bVugJuERHtaxYT0GoReUNEBjyADbi+RmdwT2dBmfsNsQ3n2FqDU2wUuSaTOJt9D0459yUef0P8B0m6a+NcdeiUAAAAAElFTkSuQmCC">
						<span class="img"></span>
					</span>
					<span class="login-word" style="right: 15px;">| 退出 </span></a></li>
			<#else>
				<a class="click-wpcom-login" href="${mvcPath}/login">登录</a>
			</#if>
		</ul>
<!-- 	</div> -->
</div>