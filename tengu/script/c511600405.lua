--ワイゼルＣ (TF5)
--Wisel Carrier (TF5)
Duel.LoadScript("c420.lua")
function c511600405.initial_effect(c)
	--selfdes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c511600405.sdcon)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(c511600405.indval)
	c:RegisterEffect(e2)
end
c511600405.listed_series={0x562}
function c511600405.sdcon(e)
	return not Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsInfinity),0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c511600405.indval(e,re,tp)
	return e:GetHandlerPlayer()~=re:GetHandlerPlayer()
end