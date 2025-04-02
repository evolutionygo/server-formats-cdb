--シンクロ・マテリアル
--Synchro Material (anime)
function c511002750.initial_effect(c)
	--All monsters can be used as synchro material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002750(c511002750,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511002750.activate)
	c:RegisterEffect(e1)
end
function c511002750.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SYNCHRO_MATERIAL)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end