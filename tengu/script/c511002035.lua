--ナチュル・バンブーシュート
--Battleguard King
function c511002035.initial_effect(c)
	--mat check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c511002035.valcheck)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c511002035.regcon)
	e2:SetOperation(c511002035.regop)
	c:RegisterEffect(e2)
	e2:SetLabelObject(e1)
end
c511002035.listed_series={0x2178}
function c511002035.valcheck(e,c)
	local g=c:GetMaterial()
	local flag=0
	if g and g:IsExists(Card.IsSetCard,1,nil,0x2178)
		then flag=1
	end
	e:SetLabel(flag)
end
function c511002035.regcon(e,tp,eg,ep,ev,re,r,rp)
	return (e:GetHandler():GetSummonType()&SUMMON_TYPE_TRIBUTE)==SUMMON_TYPE_TRIBUTE
		and e:GetLabelObject():GetLabel()~=0
end
function c511002035.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e2:SetCondition(c511002035.atcon)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e2)
end
function c511002035.atcon(e)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end