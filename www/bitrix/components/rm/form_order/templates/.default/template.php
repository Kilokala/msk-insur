<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}
?>

<div class="bContent">
    <div class="bContent__eRightCol bContent__eRightCol__mWidth_full">
        <div class="bRightColBg">
            <h1>Корпоративным клиентам</h1>

            <?=$arResult['MESSAGE']?>

            <div class="bApplication">
                <form method="POST" action="" name="applicationForm" id="applicationForm">
					<input type="hidden" name="form_send" value="Y">
                    <div class="bApplication__eFirstStep">
                        <span class="bApplication__eLeaveApplicationText">Заявка на&nbsp;подбор<br/>страховой программы</span><br/>
                        <select class="bSupplierList bSupplierList__mType_long" name="type">
							<?
							foreach ($arResult['TYPES'] as $id => $type) {
								if ($id === 10) {
									continue;
								}
								$sel = (int)$_POST['type'] === (int)$id ? 'selected ' : '';
								echo'<option class="bSupplierList__eItem" ' . $sel . 'value="' . $id . '">' . $type
									. '</option>';
							}
							?>
                        </select>
                    </div>
                    <div class="bApplication__eSplitter"></div>
                    <div class="bApplicationForm">
                        <div class="bApplicationForm__eLine">
                            <div class="bApplicationForm__eArrowWrapper">
                                <span class="bApplicationForm__eArrowText">Имя</span>
                                <span class="bApplicationForm__eArrowAngle"></span>
                            </div>
                            <input type="text" class="bApplicationForm__eInput bApplicationForm__eInput__mWidth_short"
                                   id="name" name="name" value="<?=$_POST['name']?>">
                        </div>
                        <div class="bApplicationForm__eLine">
                            <div class="bApplicationForm__eArrowWrapper">
                                <span class="bApplicationForm__eArrowText">Фамилия</span>
                                <span class="bApplicationForm__eArrowAngle"></span>
                            </div>
                            <input type="text" class="bApplicationForm__eInput bApplicationForm__eInput__mWidth_short"
                                   id="sname" name="sname" value="<?=$_POST['sname']?>">
                        </div>
                        <div class="bApplicationForm__eLine bApplicationForm__eLine__mBottomSpace_disable">
                            <div class="bApplicationForm__eArrowWrapper">
                                <span class="bApplicationForm__eArrowText">Телефон</span>
                                <span class="bApplicationForm__eArrowAngle"></span>
                            </div>
                            <input type="text" class="bApplicationForm__eInput bApplicationForm__eInput__mWidth_short"
                                   id="phone" name="phone" value="<?=$_POST['phone']?>">
                        </div>
                    </div>
                    <!-- .bApplicationForm -->
                    <div class="bApplication__eSplitter"></div>
                    <div class="bApplication__eSend">
                        <a href="#" class="bApplication__eSendLink">
                            <img src="/images/count.png" class="bApplication__eSendLinkImage" width="174" height="53"
                                 alt="">
                        </a>

                        <div class="bApplication__eSendText">Наш специалист перезвонит Вам и&nbsp;уточнив детали сообщит
                            сумму страховки.
                        </div>
                    </div>
                </form>
            </div>
            <!-- .bApplication -->
        </div>
        <!-- .bRightColBg -->
    </div>
    <!-- .bContent__eRightCol -->
    <div class="bContent__eClear"></div>
</div><!-- .bContent -->

<script type="text/javascript">
    jQuery(function ($) {
        $('a.bApplication__eSendLink').on('click', function () {
            $(this).closest('form').trigger('submit');
            return false;
        })
    });
</script>

<?

//debug($arResult);
