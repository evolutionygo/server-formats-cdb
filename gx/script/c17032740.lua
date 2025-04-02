--E・HERO カオス・ネオス
--Elemental HERO Chaos Neos
function c17032740.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Summon Procedure
	aux.AddFusionProcCode2(c,true,true,CARD_NEOS,43237273,17732278)
	Fusion.AddContactProc(c,c17032740.contactfil,c17032740.contactop,c17032740.splimit)
	aux.EnableNeosReturn(c,nil,nil,c17032740.retop)
	--Toss a coin 3 times and apply the appropriate effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc17032740(c17032740,1))
	e1:SetCategory(CATEGORY_COIN+CATEGORY_DESTROY+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c17032740.coincon)
	e1:SetTarget(c17032740.cointg)
	e1:SetOperation(c17032740.coinop)
	c:RegisterEffect(e1)
end
c17032740.listed_names={CARD_NEOS}
c17032740.material_setcode={SET_HERO,SET_ELEMENTAL_HERO,SET_NEOS,SET_NEO_SPACIAN}
c17032740.toss_coin=true
function c17032740.contactfil(tp)
	return Duel.GetMatchingGroup(Card.IsAbleToDeckOrExtraAsCost,tp,LOCATION_ONFIELD,0,nil)
end
function c17032740.contactop(g,tp)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_COST+REASON_MATERIAL)
end
function c17032740.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c17032740.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
end
function c17032740.coincon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsPhase(PHASE_MAIN1)
end
function c17032740.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c17032740.coinop(e,tp,eg,ep,ev,re,r,rp)
	local total_heads=Duel.CountHeads(Duel.TossCoin(tp,3))
	if total_heads==3 then
		local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
		Duel.Destroy(g,REASON_EFFECT)
	elseif total_heads==2 then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
		local c=e:GetHandler()
		for tc in g:Iter() do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESETS_STANDARD_PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESETS_STANDARD_PHASE_END)
			tc:RegisterEffect(e2)
		end
	elseif total_heads==1 then
		local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_MZONE,0,nil)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end