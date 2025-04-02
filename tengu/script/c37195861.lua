--Ｅ・ＨＥＲＯ オーシャン
--Elemental HERO Ocean
function c37195861.initial_effect(c)
	--Return 1 "HERO" monster you control or in your GY to the hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc37195861(c37195861,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(function(e,tp) return Duel.IsTurnPlayer(tp) end)
	e1:SetTarget(c37195861.thtg)
	e1:SetOperation(c37195861.thop)
	c:RegisterEffect(e1)
end
c37195861.listed_series={SET_HERO}
function c37195861.thfilter(c)
	return c:IsSetCard(SET_HERO) and c:IsMonster() and c:IsAbleToHand() and c:IsFaceup()
end
function c37195861.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE|LOCATION_GRAVE) and chkc:IsControler(tp) and c37195861.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c37195861.thfilter,tp,LOCATION_MZONE|LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c37195861.thfilter,tp,LOCATION_MZONE|LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,tp,0)
end
function c37195861.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsControler(tp) and c37195861.thfilter(tc) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end