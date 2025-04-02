--フレンドッグ (Anime)
--Wroughtweiler (Anime)
--Scripted by IanxWaifu, rescripted by Larry126
function c511024001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511024001(c511024001,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511024001.condition)
	e1:SetTarget(c511024001.target)
	e1:SetOperation(c511024001.operation)
	c:RegisterEffect(e1)
end
c511024001.listed_names={CARD_POLYMERIZATION}
c511024001.listed_series={0x3008}
function c511024001.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511024001.filter1(c)
	return c:IsSetCard(0x3008) and c:IsAbleToHand()
end
function c511024001.filter2(c)
	return c:IsCode(CARD_POLYMERIZATION) and c:IsAbleToHand()
end
function c511024001.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c511024001.filter1,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingTarget(c511024001.filter2,tp,LOCATION_GRAVE,0,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=Duel.SelectTarget(tp,c511024001.filter1,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g2=Duel.SelectTarget(tp,c511024001.filter2,tp,LOCATION_GRAVE,0,1,1,nil)
		g1:Merge(g2)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,2,0,0)
	end
end
function c511024001.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if #sg==2 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end