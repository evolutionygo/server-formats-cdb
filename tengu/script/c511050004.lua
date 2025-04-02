--デストーイ・チェーン・シープ (Anime)
--Frightfur Sheep (Anime)
function c511050004.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Summon Procedure
	aux.AddFusionProcCode2(c,true,true,98280324,61173621)
	--Your opponent cannot activate Spell/Trap cards and their effects until the end of the Battle Phase
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511050004(c511050004,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,0,EFFECT_COUNT_CODE_CHAIN)
	e1:SetCondition(c511050004.accon)
	e1:SetOperation(c511050004.acop)
	c:RegisterEffect(e1)
end
function c511050004.accon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler() and not e:GetHandler():HasFlagEffect(c511050004)
end
function c511050004.acop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(c511050004,RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_BATTLE,0,1)
	--Prevent activations until the end of the Battle Phase
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(c511050004.aclimit)
	e1:SetReset(RESET_PHASE|PHASE_BATTLE)
	Duel.RegisterEffect(e1,tp)
end
function c511050004.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end