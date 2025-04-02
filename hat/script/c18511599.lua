--エヴォルカイザー・ソルデ
--Evolzar Solda
function c18511599.initial_effect(c)
	--Xyz Summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunctionEx(Card.IsRace,RACE_DINOSAUR),6,2)
	c:EnableReviveLimit()
	--Cannot be destroyed by card effects while it has Xyz Material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c18511599.indcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Summon destruction
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc18511599(c18511599,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(aux.dxmcostgen(1,1,nil))
	e2:SetTarget(c18511599.target)
	e2:SetOperation(c18511599.operation)
	c:RegisterEffect(e2,false,REGISTER_FLAG_DETACH_XMAT)
end
function c18511599.indcon(e)
	return e:GetHandler():GetOverlayCount()~=0
end
function c18511599.filter(c,e,tp)
	return c:IsSummonPlayer(1-tp) and (not e or c:IsRelateToEffect(e))
end
function c18511599.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c18511599.filter,1,nil,nil,tp) end
	local g=eg:Filter(c18511599.filter,nil,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c18511599.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c18511599.filter,nil,e,tp)
	Duel.Destroy(g,REASON_EFFECT)
end