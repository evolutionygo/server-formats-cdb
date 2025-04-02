--Ｎｏ．１０５ ＢＫ 流星のセスタス (Anime)
--Number 105: Battlin' Boxer Star Cestus (Anime)
Duel.LoadCardScript("c59627393.lua")
function c511010105.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon procedure
	aux.AddXyzProcedure(c,nil,4,3)
	--Cannot be destroyed by battle, except with a "Number" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,SET_NUMBER)))
	c:RegisterEffect(e1)
	--Battle cannot be negated/your opponent takes battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511010105(c511010105,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(TIMING_BATTLE_PHASE)
	e2:SetCondition(function() return Duel.IsBattlePhase() end)
	e2:SetCost(aux.dxmcostgen(1,1,nil))
	e2:SetTarget(c511010105.target)
	e2:SetOperation(c511010105.operation)
	c:RegisterEffect(e2,false,REGISTER_FLAG_DETACH_XMAT)
end
c511010105.listed_series={SET_NUMBER}
c511010105.aux.xyz_number=105
function c511010105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:IsOnField() and bc:GetAttack()>c:GetAttack() and bc:IsFaceup() end
end
function c511010105.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if not (c:IsRelateToBattle() and tc:IsRelateToBattle()) then return end
	--Cannot be destroyed by this battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE|PHASE_DAMAGE)
	c:RegisterEffect(e1)
	--Battle cannot be negated
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UNSTOPPABLE_ATTACK)
	e2:SetReset(RESET_PHASE|PHASE_DAMAGE)
	Duel.GetAttacker():RegisterEffect(e2)
	--Your opponent takes any battle damage you would have taken
	local e3=e1:Clone()
	e3:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	c:RegisterEffect(e3)
end