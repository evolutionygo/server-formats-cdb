--DDイービル
--D/D Evil
--Scripted by Lyris
local s,c511007001,alias=GetID()
function c511007001.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--Pendulum Summon
	Pendulum.AddProcedure(c)
	--Pendulum Effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511007001(alias,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetCondition(c511007001.atkcon)
	e1:SetOperation(c511007001.atkop)
	c:RegisterEffect(e1)
end
function c511007001.cfilter(c,tp)
	return c:IsControler(tp) and c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c511007001.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511007001.cfilter,1,nil,1-tp)
end
function c511007001.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=eg:Filter(c511007001.cfilter,nil,1-tp)
	for tc in aux.Next(g) do
		local e0=Effect.CreateEffect(c)
		e0:SetType(EFFECT_TYPE_SINGLE)
		e0:SetCode(EFFECT_DISABLE)
		e0:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e0)
		local e1=e0:Clone()
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		tc:RegisterEffect(e1)
		local e2=e0:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		tc:RegisterEffect(e2)
	end
end