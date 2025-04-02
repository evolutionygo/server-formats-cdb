--レアル・クルセイダー
--Absolute Crusader
function c70832512.initial_effect(c)
	--Destroy level 5 or higher monsters that are Special Summoned
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc70832512(c70832512,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c70832512.descond)
	e1:SetCost(aux.SelfTributeCost)
	e1:SetTarget(c70832512.destg)
	e1:SetOperation(c70832512.desop)
	c:RegisterEffect(e1)
end
function c70832512.desfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(5)
end
function c70832512.descond(e,tp,eg,ep,ev,re,r,rp,chk)
	return eg:IsExists(c70832512.desfilter,1,e:GetHandler())
end
function c70832512.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=eg:Filter(c70832512.desfilter,e:GetHandler(),nil)
	Duel.SetTargetCard(dg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,#dg,0,0)
end
function c70832512.desop(e,tp,eg,ep,ev,re,r,rp)
	local dg=eg:Filter(c70832512.desfilter,nil):Filter(Card.IsRelateToEffect,nil,e)
	if #dg>0 then
		Duel.Destroy(dg,REASON_EFFECT)
	end
end