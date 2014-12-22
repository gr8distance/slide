Slide = require "./slide.coffee"
ex = require("expect.js")
re_win = [
	{w: 640,h:1138},
	{w: 1280,h:720}
	{w: 1920,h:1080},
	{w: 2560,h:1440},
	{w: 2880,h:1800}
]
images = []
for i in [0..2]
	images[i] = "image#{i}.jpg"


describe("Slide",->
	s = new Slide 1280,720,images
	
	#コンストラクタ
	it "コンストラクターの処理",->
		ex(s.w).to.be(1280)
		ex(s.h).to.be(720)
	
	#画像の数を数えます
	it "画像のプロパティの数を確認します",->
		ex(s.images.length).to.be images.length
	
	it "画像の名前情報の確認を行います", ->
		for i in [0...images.length]
			ex(s.images[i].name).to.be images[i]

	it "画像のポジションについての確認を行います", ->
		for i in [0...images.length]
			if i != (images.length - 1)
				ex(s.images[i].left).to.be(1280*i)
			else
				ex(s.images[i].left).to.be(0 - 1280)
	
	it "画像の倍数はここに記述",->
		c = 0
		for i in [0...s.images.length]
			if i == (s.images.length - 1)
				ex(s.images[i].multi).to.be -1
			else
				ex(s.images[i].multi).to.be(c)
			c+=1
	#コンストラクタの処置はここまでです

	
	#Resizeメソッドのテスト
	it "画面リサイズの時のサイズについて",->
		for i in re_win
			s.resize i.w,i.h
			ex(s.w).to.be i.w
			ex(s.h).to.be i.h
	
	
	it "画面リサイズ時のプロパティの状態",->
		datas = s.images
		s.resize 2000,1000



	#画像を右側に送り込むテスト
	#it "imagesプロパティの操作を行うR",->

	##画像を左側に送り込む
	#it "imagesプロパティの操作を行うL", ->
	#	datas = s.images
	#	max_i = s.biggest_data datas
	#	s.left()
	#	for i in [0...s.images.length]
	#		if i == max_i
	#			ex(s.images[i].left).to.be(0 - s.w)
	#		else
	#			ex(s.images[i].left).to.be(datas[i].left)


	#配列の最大値を取得してその添字を返す
	it "配列内の最大値を取得しその添字を返す", ->
		datas = [100,300,500,200,150]
		ex(s.biggest_data(datas)).to.be 2
	
	it "配列内の最小値を取得してその添字を返す",->
		datas = [100,300,500,50,250]
		ex(s.smallest_data(datas)).to.be 3

	#連想配列から指定のキーの値だけを抽出した配列を返す
	it "連想配列とキーを引数に取り指定の値を抜き出す",->
		datas = s.get_hash_value re_win,"w"
		ex(datas.length).to.be re_win.length
		for i in [0...datas.length]
			ex(datas[i]).to.be re_win[i].w 
		
		for i in [0...datas.length]
			ex(datas[i]).not.to.be re_win[i].h


	 #it "画面リサイズした後にスライド処理が実行されているか",->
		

	









)#テスト終了のお知らせ
console.log "Test ended!"
