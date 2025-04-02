--憑依装着－ウィン
--Familiar-Possessed - Wynn
function c31764353.initial_effect(c)
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCondition(c31764353.spcon)
	e1:SetTarget(c31764353.sptg)
	e1:SetOperation(c31764353.spop)
	c:RegisterEffect(e1)
end
c31764353.listed_names={37744402}
function c31764353.spfilter1(c)
	return c:IsFaceup() and c:IsCode(37744402) and c:IsAbleToGraveAsCost()
end
function c31764353.spfilter2(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND) and c:IsAbleToGraveAsCost()
end
function c31764353.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c31764353.chk,1,nil,sg)
end
function c31764353.chk(c,sg)
	return c:IsCode(37744402) and sg:IsExists(Card.IsAttribute,1,c,ATTRIBUTE_WIND)
end
function c31764353.spcon(e,c)
	if c==nil then return true end
	local tp=e:GetHandlerPlayer()
	local g1=Duel.GetMatchingGroup(c31764353.spfilter1,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c31764353.spfilter2,tp,LOCATION_MZONE,0,nil)
	local g=g1:Clone()
	g:Merge(g2)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2 and #g1>0 and #g2>0 and aux.SelectUnselectGroup(g,e,tp,2,2,c31764353.rescon,0)
end
function c31764353.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	local g1=Duel.GetMatchingGroup(c31764353.spfilter1,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c31764353.spfilter2,tp,LOCATION_MZONE,0,nil)
	g1:Merge(g2)
	local g=aux.SelectUnselectGroup(g1,e,tp,2,2,c31764353.rescon,1,tp,HINTMSG_TOGRAVE)
	if #g>0 then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c31764353.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.SendtoGrave(g,REASON_COST)
	Duel.ShuffleDeck(tp)
	--pierce
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE&~RESET_TOFIELD)
	e:GetHandler():RegisterEffect(e1)
	g:DeleteGroup()
end