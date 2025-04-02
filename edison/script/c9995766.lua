--宮廷のしきたり
--Imperial Custom, OCG
function c9995766.initial_effect(c)
	c:SetUniqueOnField(1,0,c9995766)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Continuous traps cannot be destroyed by battle or card effects
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e2:SetTarget(c9995766.infilter)
	e2:SetValue(c9995766.indesval)
	c:RegisterEffect(e2)
end
function c9995766.infilter(e,c)
	return (c:GetType()&0x20004)==0x20004 and c:GetCode()~=c9995766
end
function c9995766.indesval(e,re,r,rp)
	return (r&REASON_EFFECT+REASON_BATTLE)~=0
end