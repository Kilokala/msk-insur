$(document).ready(function() {


/*                        Слайдер партнеров                               */
	var animationSpeed = 500,
		$galleryLine = $('.bPartnersSlider__eLine'),
		$galleryImagesArray = $galleryLine.find('.bPartnersSlider__eImage'),
		imageWidth = $galleryImagesArray.eq(0).outerWidth(true),
		sizeGal = $galleryImagesArray.length;

	$('.bPartnersSlider__eArrowRight').click(function(){
		$galleryLine.animate({"left": -imageWidth+"px"}, animationSpeed, function(){
			var $firstImage = $galleryLine.find(".bPartnersSlider__eImage").first();
			$galleryLine.append($firstImage);
			$galleryLine.css({"left":"0"});
		});
	});

	$('.bPartnersSlider__eArrowLeft').click(function(){
		var $lastImage = $galleryLine.find('.bPartnersSlider__eImage').last();
		$galleryLine.prepend($lastImage);
		$galleryLine.css({ left: -imageWidth + 'px'});
		$galleryLine.animate({'left': '0'}, animationSpeed);
	});

/*                          Второстепенное меню                           */

	var menuItem = $('.bMenu__eItem'),
		active = 'bMenu__eItemLink__mState_active',
		menuItemLink = $('.bMenu__eItemLink'),
		subMenu = $('.bSubMenu');

	menuItemLink.on('mouseenter', function(){
		$(this).parent(menuItem).find(subMenu).slideDown('slow');
		$(this).addClass(active);
	});

	menuItem.on('mouseleave', function(){
		$(this).parent(menuItem).find(subMenu).slideUp('slow');
		menuItemLink.removeClass(active);
	});

/*                        Списки вакансий                               */
	$('.bVacancy__eTitle').on('click', function(){
		$(this).toggleClass('bVacancy__eTitle__mType_active');
		$(this).parents('.bVacancy').find('.bVacancy__eTextWrapper').slideToggle('slow');
	})

/*                        Слайдер баннера                               */

    /* Создаем переменные */
    var switcher = $('.bSliderControls__eBullet'),
        active = 'bSliderControls__eBullet__mState_active',
		disable = 'bBanner__eLine__mTransition_disable',
        panel = $('.bBanner__eLine'),
        sliderLength = panel.find('img').length,
        panelImageWidth = $('.bBanner__eImage').outerWidth(true),
        images = $('.bBanner__eImage');
        
    /* Реагируем на нажатие переключателя */
    function slide(i){
        var curswitcher = switcher.eq(i - 1),
            iPrev = switcher.index($('.' + active)) + 1,
            shift = -(panelImageWidth * i);

        /* Проверяем, какой переключатель сейчас активный */
        if (curswitcher.hasClass(active)){
            return true;
        } /* Если текущий не активный, то делаем его активным */
        else {
            switcher.removeClass(active);
            curswitcher.addClass(active);
        }
		/* Если находимся на последнем и кликаем на первый, то делаем прокрутку без обратного сдвига с эффектом прокрутки вперед */
        if (iPrev == 4 && i == 1){
            var shift = -(panelImageWidth);
            panel.addClass(disable);
            panel.css('left', '0px');
            setTimeout(function() {
                panel.removeClass(disable);
                setTimeout(function() {
                    panel.css('left', shift);
                }, 1);
            }, 50);
                
        } else {
            /* Двигаем слайдер на нужное количество шагов */
            panel.css('left', shift);
        }
    }
    switcher.click(function() {
        var i = switcher.index(this)
        slide(i + 1);
    });
    
    images.click(function(){
        var i = switcher.index($('.' + active));
        if (i == 3) i = -1;
        slide(++i + 1);
    });

});