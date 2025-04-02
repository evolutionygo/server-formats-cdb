--スノーダスト・ジャイアント
--Snowdust Giant
function c73659078.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon procedure
	aux.AddXyzProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_WATER),4,2)
	--Place Ice Counters on face-up monsters on the field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc73659078(c73659078,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(aux.dxmcostgen(1,1,nil))
	e1:SetTarget(c73659078.countertg)
	e1:SetOperation(c73659078.counterop)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--Non-WATER monsters lose 200 ATK for each Ice Counter on the field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(function(_,c) return c:IsAttributeExcept(ATTRIBUTE_WATER) end)
	e2:SetValue(function() return Duel.GetCounter(0,1,1,0x1015)*-200 end)
	c:RegisterEffect(e2)
end
c73659078.counter_list={0x1015}
function c73659078.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and not c:IsPublic()
end
function c73659078.countertg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c73659078.cfilter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c73659078.counterop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if #g==0 then return end
	local hg=Duel.GetMatchingGroup(c73659078.cfilter,tp,LOCATION_HAND,0,nil)
	if #hg==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local rg=hg:Select(tp,1,#hg,nil)
	Duel.ConfirmCards(1-tp,rg)
	Duel.ShuffleHand(tp)
	local ct=#rg
	local tc=nil
	for i=1,ct do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COUNTER)
		tc=g:Select(tp,1,1,nil):GetFirst()
		tc:AddCounter(0x1015,1)
	end
end