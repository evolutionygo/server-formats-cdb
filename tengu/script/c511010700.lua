--暗黒の扉 (Manga)
--The Dark Door (Manga)
--added by ClaireStanfield
function c511010700.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c511010700.atkcon)
	e2:SetTarget(c511010700.atktg)
	c:RegisterEffect(e2)
	--check
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511010700.checkop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c511010700.atkcon(e)
	return e:GetHandler():GetFlagEffect(c511010700)~=0
end
function c511010700.atktg(e,c)
	return c:GetFieldID()~=e:GetLabel()
end
function c511010700.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(c511010700)~=0 then return end
	local fc511010700=eg:GetFirst():GetFieldID()
	e:GetHandler():RegisterFlagEffect(c511010700,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fc511010700)
end