--機皇廠
--Meklord Factory
function c77864539.initial_effect(c)
	--Add 1 "Meklord Army" monster to the hand and destroy 1 monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc77864539(c77864539,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c77864539.condition)
	e1:SetTarget(c77864539.target)
	e1:SetOperation(c77864539.activate)
	c:RegisterEffect(e1)
end
c77864539.listed_series={SET_MEKLORD,SET_MEKLORD_ARMY}
function c77864539.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d:IsFaceup() and d:IsSetCard(SET_MEKLORD)
end
function c77864539.filter(c)
	return c:IsSetCard(SET_MEKLORD_ARMY) and c:IsAbleToHand()
end
function c77864539.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c77864539.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c77864539.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c77864539.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local d=Duel.GetAttackTarget()
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,d,1,0,0)
end
function c77864539.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		local d=Duel.GetAttackTarget()
		if d:IsRelateToBattle() then
			Duel.Destroy(d,REASON_EFFECT)
		end
	end
end