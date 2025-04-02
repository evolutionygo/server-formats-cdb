--堕天使ゼラート
--Darklord Zerato
function c40921744.initial_effect(c)
	--Can be Tribute Summoned using 1 DARK monster
	local e1=aux.AddNormalSummonProcedure(c,true,true,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc40921744(c40921744,0),c40921744.otfilter)
	local e2=aux.AddNormalSetProcedure(c,true,true,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc40921744(c40921744,0),c40921744.otfilter)
	--Destroy all monsters your opponent controls
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc40921744(c40921744,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c40921744.descost)
	e3:SetTarget(c40921744.destg)
	e3:SetOperation(c40921744.desop)
	c:RegisterEffect(e3)
	--Destroy this card during the End Phase
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc40921744(c40921744,2))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(function(e) return e:GetHandler():HasFlagEffect(c40921744) end)
	e4:SetTarget(c40921744.selfdestg)
	e4:SetOperation(c40921744.selfdesop)
	c:RegisterEffect(e4)
end
function c40921744.otfilter(c,tp)
	local ag=Duel.GetMatchingGroup(Card.IsAttribute,tp,LOCATION_GRAVE,0,nil,ATTRIBUTE_DARK)
	return c:IsAttribute(ATTRIBUTE_DARK) and ag:GetClassCount(Card.GetCode)>=4
end
function c40921744.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsAbleToGraveAsCost()
end
function c40921744.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c40921744.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c40921744.cfilter,1,1,REASON_COST)
	e:GetHandler():RegisterFlagEffect(c40921744,RESETS_STANDARD_PHASE_END,EFFECT_FLAG_OATH,1)
end
function c40921744.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c40921744.desop(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c40921744.selfdestg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c40921744.selfdesop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Destroy(c,REASON_EFFECT)
	end
end