--フレンドッグ
--Wroughtweiler
function c6480253.initial_effect(c)
	--Add 1 "Elemental HERO" card and 1 "Polymerization" from your GY to your hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc6480253(c6480253,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(function(e) return e:GetHandler():IsLocation(LOCATION_GRAVE) end)
	e1:SetTarget(c6480253.thtg)
	e1:SetOperation(c6480253.thop)
	c:RegisterEffect(e1)
end
c6480253.listed_series={SET_ELEMENTAL_HERO}
c6480253.listed_names={CARD_POLYMERIZATION}
function c6480253.thfilter(c,e)
	return (c:IsSetCard(SET_ELEMENTAL_HERO) or c:IsCode(CARD_POLYMERIZATION)) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function c6480253.rescon(sg,e,tp,mg)
	return sg:IsExists(Card.IsSetCard,1,nil,SET_ELEMENTAL_HERO) and sg:IsExists(Card.IsCode,1,nil,CARD_POLYMERIZATION)
end
function c6480253.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c6480253.thfilter,tp,LOCATION_GRAVE,0,nil,e)
	local tg=aux.SelectUnselectGroup(g,e,tp,2,2,c6480253.rescon,1,tp,HINTMSG_ATOHAND)
	if #tg>0 then
		Duel.SetTargetCard(tg)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,tg,2,tp,0)
	end
end
function c6480253.thop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetCards(e)
	if tg and #tg>0 then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end