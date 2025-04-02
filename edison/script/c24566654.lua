--クリムゾン・ヘルフレア
--Crimson Fire
function c24566654.initial_effect(c)
	--Your opponent takes twice the effect damage you would have taken
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc24566654(c24566654,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c24566654.condition)
	e1:SetOperation(c24566654.operation)
	c:RegisterEffect(e1)
end
c24566654.listed_names={CARD_RED_DRAGON_ARCHFIEND}
function c24566654.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,CARD_RED_DRAGON_ARCHFIEND),tp,LOCATION_ONFIELD,0,1,nil)
		and ep==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and aux.damcon1(e,tp,eg,ep,ev,re,r,rp)
end
function c24566654.operation(e,tp,eg,ep,ev,re,r,rp)
	local cc24566654=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cc24566654)
	e1:SetValue(c24566654.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetLabel(cc24566654)
	e2:SetValue(c24566654.dammul)
	e2:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e2,tp)
end
function c24566654.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or (r&REASON_EFFECT)==0 then return end
	local cc24566654=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	return cc24566654==e:GetLabel()
end
function c24566654.dammul(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or (r&REASON_EFFECT)==0 then return end
	local cc24566654=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	return cc24566654==e:GetLabel() and val*2 or val
end