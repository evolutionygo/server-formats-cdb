--E・HERO アブソルートZero
--Elemental HERO Absolute Zero
function c40854197.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,aux.FilterBoolFunctionEx(Card.IsSetCard,0x8),aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_WATER))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc40854197(c40854197,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c40854197.descon)
	e2:SetTarget(c40854197.destg)
	e2:SetOperation(c40854197.desop)
	c:RegisterEffect(e2)
	--increase ATK
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c40854197.atkup)
	c:RegisterEffect(e3)
end
c40854197.listed_series={0x8}
c40854197.material_setcode={0x8}
function c40854197.atkfilter(c)
	return c:IsFaceup() and c:GetCode()~=c40854197 and c:IsAttribute(ATTRIBUTE_WATER)
end
function c40854197.atkup(e,c)
	return Duel.GetMatchingGroupCount(c40854197.atkfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)*500
end
function c40854197.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c40854197.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c40854197.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end