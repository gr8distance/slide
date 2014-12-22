class Slide
	
	constructor: (@w,@h,images)->
		@images = set_prop(@w,images)

	#画像のポジションと名前を決定するコード
	set_prop = (w,images) ->
		data = []
		for i in [0...images.length]
			data[i] = {
				name: images[i],
				left: if i == (images.length-1) then 0-w else i*w,
				multi: if i == (images.length-1) then -1 else i
			}
		return data
	
	#画像のポジションと名前を決定するコード
	re_set_prop = (w,images) ->
		data = []
		for i in [0...images.length]
			data[i] = {
				name: images[i].name,
				left: if i == (images.length-1) then 0-w else i*w
			}
		return data
		
	
	#画面リサイズのコード
	resize: (w,h)->
		@w = w
		@h = h
			

	left: ->
		for i in [0...@images.length]
			if @images[i].multi == (@images.length - 2)
				@images[i].multi = -1
			else
				@images[i].multi += 1
		#		big_num = this.biggest_data(this.get_hash_value(@images,"left"))
		#		for i in [0...@images.length]
		#			@images[i].left = if i == big_num then (0-@w) else @images[i].left+@w
		#

	right: ->
		for i in [0...@images.length]
			if @images[i].multi == -1
				@images[i].multi = (@images.length - 2)
			else
				@images[i].multi -= 1
		#small_num = this.smallest_data(this.get_hash_value(@images,"left"))
		#for i in [0...@images.length]
		#	if @images[i].left >= 0
		#		@images[i].left -= @w
		#	else
		#		@images[i].left = @w * (@images.length - 2)




	biggest_data: (datas)->
		big_num = Math.max.apply(null,datas)
		for i in [0...datas.length]
			if datas[i] == big_num
				return i




	smallest_data: (datas)->
		small_num = Math.min.apply(null,datas)
		for i in [0...datas.length]
			return i if datas[i]==small_num




	get_hash_value: (datas,key)->
		ret_datas = []
		for i in datas
			ret_datas.push i[key]
		return ret_datas

$ ->
	w = $(window)
	ws = [w.width(),w.height()]
	images= []
	for i in [0...5]
		images[i] = "#i#{i+1}"
	for i in images
		console.log i
	$(".slides").css({"height": ws[1]})

	s = new Slide ws[0],ws[1],images
	
	for i in s.images
		$(i.name).css({
			"width": s.w,
			"height": s.h,
			"left": s.w * i.multi
		})

	$(".button").click(->
		attr = $(this).attr("id")

		switch attr
			when "left"
				s.left()
				for i in s.images
					if i.multi == 0 || i.multi == 1
						$(i.name).animate({
							"left": i.multi * s.w
						},{
							"duration": 1200,
							"easing": "easeInOutQuint"
						})
					else
						$(i.name).css({
							"left": i.multi * s.w
						})
			when "right"
				s.right()
				for i in s.images
					if i.multi == 0 || i.multi == -1
						$(i.name).animate({
							"left": i.multi * s.w
						},{
							"duration": 1200,
							"easing": "easeInOutQuint"
						})
					else
						$(i.name).css({
							"left": i.multi * s.w
						})
	)

	#画像のリサイズ時
	w.resize(->
		r = $(this)
		rs = [r.width(),r.height()]
		$(".slides").css({"height": rs[1],"width": rs[0]})
		
		s.resize rs[0],rs[1]
		for i in s.images
			$(i.name).css({
				"left": (s.w* i.multi),
				"width": s.w,
				"height": s.h
			})

	)

