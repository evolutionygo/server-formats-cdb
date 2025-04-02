--覇勝星イダテン (Anime)
--Idaten the Conqueror Star (Anime)
Duel.LoadScript("c420.lua")
function c511002013.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,aux.FilterBoolFunctionEx2(Card.IsSky),aux.FilterBoolFunctionEx2(Card.IsEarth))
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511002013.atkcon)
	e1:SetOperation(c511002013.atkop)
	c:RegisterEffect(e1)
end
c511002013.material_setcode={0x54a,0x51a}
function c511002013.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and c:GetLevel()>=bc:GetLevel() and bc:IsControler(1-tp)
end
function c511002013.atkop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc and bc:IsFaceup() and bc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(0)
		bc:RegisterEffect(e1)
	end
end